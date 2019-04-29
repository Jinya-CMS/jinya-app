package de.jinya.app.http

import kotlinx.serialization.Serializable

@Serializable
data class JinyaError(
    val message: CharSequence,
    val type: CharSequence,
    val exception: CharSequence? = null,
    val file: CharSequence? = null,
    val stack: CharSequence? = null,
    val line: Int? = null
)

@Serializable
data class JinyaErrorResponse(
    val success: Boolean,
    val error: JinyaError
)

@Serializable
data class JinyaValidationResponse(
    val success: Boolean,
    val validation: Map<String, String>
)