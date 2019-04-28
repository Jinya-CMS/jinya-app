import org.json.JSONArray

operator fun <T> JSONArray.iterator(): Iterator<T> = (0 until length()).asSequence().map { get(it) as T }.iterator()