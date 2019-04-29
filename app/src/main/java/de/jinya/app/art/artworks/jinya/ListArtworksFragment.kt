package de.jinya.app.art.artworks.jinya

import android.graphics.Color
import android.graphics.drawable.ColorDrawable
import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.fragment.app.Fragment
import com.github.kittinunf.fuel.core.isSuccessful
import com.github.kittinunf.fuel.httpGet
import de.jinya.app.model.Artwork
import de.jinya.app.model.JinyaList
import kotlinx.serialization.UnstableDefault
import kotlinx.serialization.json.Json
import org.jetbrains.anko.linearLayout
import org.jetbrains.anko.listView
import org.jetbrains.anko.matchParent
import org.jetbrains.anko.support.v4.UI
import org.jetbrains.anko.support.v4.longToast
import org.jetbrains.anko.wrapContent

class ListArtworksFragment : Fragment() {
    private val artworkAdapter = ListArtworkAdapter()

    @UnstableDefault
    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        "/api/artwork".httpGet().responseString { _, response, result ->
            if (response.isSuccessful) {
                val artworks = Json.parse(JinyaList.serializer(Artwork.serializer()), result.get())
                artworkAdapter.setArtworks(artworks.items)
            } else {
                longToast(result.get())
            }
        }
    }

    override fun onCreateView(inflater: LayoutInflater, container: ViewGroup?, savedInstanceState: Bundle?): View? {
        return UI {
            linearLayout {
                listView {
                    adapter = artworkAdapter
                    divider = ColorDrawable(Color.TRANSPARENT)
                }.lparams(width = matchParent, height = wrapContent)
            }
        }.view
    }
}