# Шпаргалка: Kotlin для співбесіди

Розділи відповідають темам, які ми проходили. Приклади з коду cubechat дано для пам'яті.

## 1. Null-safety

| Вираз | Що робить |
|---|---|
| `String` | не може бути `null` |
| `String?` | може бути `null` |
| `s?.length` | якщо `s == null`, результат `null` |
| `s ?: 0` | якщо зліва `null`, береться значення справа (елвіс) |
| `s!!.length` | якщо `null`, падає з `NullPointerException`. Уникати |
| `s?.let { ... }` | блок виконується, тільки якщо `s != null` |

Приклад у проєкті: `IncomingCallReceiver.kt:17`, `val key = intent.getStringExtra(...) ?: return` (ранній вихід).

## 2. val, var, data class, object, when

- `val` — посилання не можна переприсвоїти. Вміст об'єкта `val` може змінюватися (`mutableListOf`).
- `var` — посилання можна змінити.
- `data class` — сам генерує `equals`, `hashCode`, `toString`, `copy`. Порівнює за значеннями полів.
- `object` — клас-одинак.
- `companion object` — статичні члени всередині класу.
- `when` — як `switch`, але повертає значення і вміє `in 0..49`.

Приклад у проєкті: `CallService.kt:74` (`data class State`), `CallService.kt:83` (`companion object`).

## 3. Scope-функції

| Функція | Об'єкт всередині | Що повертає |
|---|---|---|
| `let` | `it` | результат блоку |
| `run` | `this` | результат блоку |
| `apply` | `this` | сам об'єкт |
| `also` | `it` | сам об'єкт |
| `with(obj)` | `this` | результат блоку |

Приклад у проєкті: `CallService.kt:129`, `apply` для налаштування сповіщення, `let` для аватара.

## 4. lateinit і by lazy

- `lateinit var` — присвоюється пізніше. Тільки для `var` і не примітивних типів. Доступ до неініціалізованого дає `UninitializedPropertyAccessException`.
- `val x by lazy { ... }` — створюється при першому зверненні, тільки для `val`, потокобезпечний за замовчуванням.

Приклад у проєкті: `IncomingCallActivity.kt:197` і `209`, `lateinit var micButton: View`. `by lazy` у проєкті немає.

## 5. Колекції і Sequence

- `List`, `Set`, `Map` — тільки читання. `MutableList` і подібні — змінювані.
- `map`, `filter` на звичайних колекціях жадібні: кожен крок створює новий список.
- `asSequence()` — ліниве обчислення: елементи йдуть по одному, `take(n)` зупиняє процес рано. Термінальна операція (`toList`, `first`) запускає обчислення.
- `Set` — перевірка `in` за хешем.
- `flatMap` — розплющує вкладені колекції, `map` — ні.

Приклад у проєкті: `DirectShareTargets.kt:37-40`.

## 6. Корутини

- `suspend` — функцію можна призупинити. Під час очікування потік вільний.
- `delay` звільняє потік. `Thread.sleep` блокує потік.
- `launch` — без результату, повертає `Job`. `async` — повертає `Deferred`, результат через `await()`.
- `Dispatchers.Main` — UI, `Dispatchers.IO` — мережа й диск, `Dispatchers.Default` — важкі обчислення.
- Структурована конкурентність: скасування області скасовує дочірні корутини.
- Відміна кооперативна: у циклі перевіряти `ensureActive()` або `isActive`. Не ковтати `CancellationException`.

У проєкті корутин немає, є `Executor`: `CubechatRadioAudioPlugin.kt:72` (`newSingleThreadExecutor`) і `103` (`exec.execute`). Відміну там зроблено вручну через лічильник `generation`.

## 7. Ще не пройдено

- `Flow`, `StateFlow`, `SharedFlow`
- Життєвий цикл Android, сервіси, `PendingIntent`, `BroadcastReceiver`
- `ViewModel`, Compose, DI
- Generics, `in`/`out`, `inline`/`reified`

## 8. Англійські терміни для співбесіди

| Українською | English |
|---|---|
| null-safety | null safety |
| клас | class |
| об'єкт | object / instance |
| успадкування | inheritance |
| інтерфейс | interface |
| колекція | collection |
| призупинити | suspend |
| відміна | cancellation |
| потік | thread |
| черга | queue |
