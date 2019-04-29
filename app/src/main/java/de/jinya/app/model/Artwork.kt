package de.jinya.app.model

import kotlinx.serialization.Serializable

@Serializable
data class Artwork(
    val name: CharSequence?,
    val slug: CharSequence?,
    val picture: CharSequence?,
    val height: Int,
    val width: Int,
    val description: CharSequence? = null
)