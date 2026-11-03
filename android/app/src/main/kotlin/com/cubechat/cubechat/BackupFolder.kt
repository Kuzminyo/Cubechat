package com.cubechat.cubechat

import android.content.Context
import android.net.Uri
import android.os.Handler
import android.os.Looper
import android.provider.DocumentsContract
import io.flutter.plugin.common.MethodChannel
import java.io.File

/**
 * The automatic backup's one file in the folder the user chose once
 * (`pickFolder` in [MainActivity]).
 *
 * Written beside the old copy and swapped in only once it is whole: a backup
 * cut short — the phone dying, the drive's app killed — must never be the
 * only copy left, and overwriting in place would make it exactly that.
 */
object BackupFolder {
    private val main = Handler(Looper.getMainLooper())

    /** The folder's name as Files shows it, for the settings row. */
    fun label(context: Context, tree: Uri): String = try {
        val folder = DocumentsContract.buildDocumentUriUsingTree(
            tree,
            DocumentsContract.getTreeDocumentId(tree),
        )
        context.contentResolver.query(
            folder,
            arrayOf(DocumentsContract.Document.COLUMN_DISPLAY_NAME),
            null,
            null,
            null,
        )?.use { cursor -> if (cursor.moveToFirst()) cursor.getString(0) else null }
            ?: tree.lastPathSegment.orEmpty()
    } catch (_: Exception) {
        tree.lastPathSegment.orEmpty()
    }

    /**
     * Copy [path] into the folder as [name], replacing what is there.
     * Answers "saved", "denied" (the folder or its permission is gone — the
     * user has to pick it again) or "failed".
     */
    fun write(
        context: Context,
        folder: String?,
        name: String?,
        path: String?,
        result: MethodChannel.Result,
    ) {
        val source = path?.let(::File)
        if (folder == null || name.isNullOrEmpty() || source == null || !source.exists()) {
            result.success("failed")
            return
        }
        Thread {
            val outcome = try {
                copy(context, Uri.parse(folder), name, source)
            } catch (_: SecurityException) {
                "denied"
            } catch (_: Exception) {
                "failed"
            }
            main.post { result.success(outcome) }
        }.start()
    }

    private fun copy(context: Context, tree: Uri, name: String, source: File): String {
        val resolver = context.contentResolver
        val held = resolver.persistedUriPermissions.any {
            it.uri == tree && it.isWritePermission
        }
        if (!held) return "denied"
        val treeId = DocumentsContract.getTreeDocumentId(tree)
        val parent = DocumentsContract.buildDocumentUriUsingTree(tree, treeId)
        val partialName = "$name.partial"
        // A leftover from a write that died halfway.
        child(context, tree, treeId, partialName)?.let {
            DocumentsContract.deleteDocument(resolver, it)
        }
        val partial = DocumentsContract.createDocument(
            resolver,
            parent,
            "application/octet-stream",
            partialName,
        ) ?: return "failed"
        resolver.openOutputStream(partial, "w")?.use { out ->
            source.inputStream().use { input -> input.copyTo(out, 1 shl 16) }
        } ?: return "failed"
        child(context, tree, treeId, name)?.let {
            DocumentsContract.deleteDocument(resolver, it)
        }
        val renamed = try {
            DocumentsContract.renameDocument(resolver, partial, name)
        } catch (_: Exception) {
            null
        }
        if (renamed == null) {
            // A provider that cannot rename: write the real name directly. The
            // finished partial is kept until that copy is whole.
            val whole = DocumentsContract.createDocument(
                resolver,
                parent,
                "application/octet-stream",
                name,
            ) ?: return "failed"
            resolver.openOutputStream(whole, "w")?.use { out ->
                source.inputStream().use { input -> input.copyTo(out, 1 shl 16) }
            } ?: return "failed"
            DocumentsContract.deleteDocument(resolver, partial)
        }
        return "saved"
    }

    private fun child(context: Context, tree: Uri, treeId: String, name: String): Uri? {
        val children = DocumentsContract.buildChildDocumentsUriUsingTree(tree, treeId)
        context.contentResolver.query(
            children,
            arrayOf(
                DocumentsContract.Document.COLUMN_DOCUMENT_ID,
                DocumentsContract.Document.COLUMN_DISPLAY_NAME,
            ),
            null,
            null,
            null,
        )?.use { cursor ->
            while (cursor.moveToNext()) {
                if (cursor.getString(1) == name) {
                    return DocumentsContract.buildDocumentUriUsingTree(tree, cursor.getString(0))
                }
            }
        }
        return null
    }
}
