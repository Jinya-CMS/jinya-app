import kotlinx.serialization.UnstableDefault
import kotlinx.serialization.json.Json
import kotlinx.serialization.json.JsonConfiguration
import org.json.JSONArray

operator fun <T> JSONArray.iterator(): Iterator<T> = (0 until length()).asSequence().map { get(it) as T }.iterator()

@UseExperimental(UnstableDefault::class)
val JsonEncoder = Json(
    JsonConfiguration(
        encodeDefaults = true,
        strictMode = false,
        unquoted = false,
        prettyPrint = false,
        useArrayPolymorphism = false,
        classDiscriminator = "type"
    )
)