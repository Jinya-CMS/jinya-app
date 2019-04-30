package de.jinya.app.art.artworks.jinya

import JsonEncoder
import android.graphics.drawable.ColorDrawable
import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.fragment.app.Fragment
import com.github.kittinunf.fuel.core.isSuccessful
import com.github.kittinunf.fuel.httpGet
import de.jinya.app.R
import de.jinya.app.http.JinyaErrorResponse
import de.jinya.app.model.Artwork
import de.jinya.app.model.JinyaControl
import de.jinya.app.model.JinyaList
import org.jetbrains.anko.*
import org.jetbrains.anko.sdk27.coroutines.onScrollListener
import org.jetbrains.anko.support.v4.UI
import org.jetbrains.anko.support.v4.longToast

class ListArtworksFragment : Fragment(), AnkoLogger {
    private val artworkAdapter = ListArtworkAdapter()
    private var control: JinyaControl? = null
    private var loading: Boolean = false

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        loadArtworks()
    }

    private fun loadArtworks() {
        if (!loading) {
            loading = true
            var url = "/api/artwork"
            if (control != null) {
                url = control!!.next
            }
            if (url != false.toString()) {
                url
                    .httpGet()
                    .responseString { _, response, result ->
                        if (response.isSuccessful) {
                            val res = result.get()
                            val artworks = JsonEncoder.parse(JinyaList.serializer(Artwork.serializer()), res)
                            control = artworks.control
                            artworkAdapter.appendArtworks(artworks.items)
                        } else {
                            val data = String(response.data)
                            val error = JsonEncoder.parse(
                                JinyaErrorResponse.serializer(),
                                data
                            )
                            longToast(error.error.message)
                            warn(error.error.type)
                            if (error.error.exception != null)
                                warn(error.error.exception)

                            if (error.error.stack != null)
                                warn(error.error.stack)
                        }
                        loading = false
                    }
            }
        }
    }

    override fun onCreateView(inflater: LayoutInflater, container: ViewGroup?, savedInstanceState: Bundle?): View? {
        return UI {
            linearLayout {
                lparams(height = matchParent, width = matchParent)
                listView {
                    adapter = artworkAdapter
                    divider = ColorDrawable(activity!!.getColor(R.color.colorPrimary))
                    onScrollListener {
                        this.onScroll { _, firstVisibleItem, visibleItemCount,
                                        totalItemCount ->
                            if (firstVisibleItem + visibleItemCount == totalItemCount && totalItemCount != 0) {
                                loadArtworks()
                            }
                        }
                    }
                }.lparams(width = matchParent, height = wrapContent)
            }
        }.view
    }
}