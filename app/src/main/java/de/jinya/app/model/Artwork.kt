package de.jinya.app.model

import kotlinx.serialization.Optional
import kotlinx.serialization.Serializable

@Serializable
data class Artwork(
    val name: CharSequence?,
    @Optional val description: CharSequence? = null,
    val slug: CharSequence?,
    val picture: CharSequence?
)