package de.jinya.app

import android.content.Context
import android.os.Bundle
import android.os.Debug
import android.view.Gravity
import android.view.View
import android.widget.LinearLayout
import androidx.appcompat.app.ActionBarDrawerToggle
import androidx.appcompat.app.AppCompatActivity
import androidx.appcompat.widget.Toolbar
import androidx.core.view.GravityCompat.START
import androidx.drawerlayout.widget.DrawerLayout
import androidx.fragment.app.Fragment
import com.github.kittinunf.fuel.core.FuelManager
import com.github.kittinunf.fuel.core.isSuccessful
import com.github.kittinunf.fuel.httpHead
import com.google.android.material.navigation.NavigationView
import com.squareup.picasso.Picasso
import de.jinya.app.art.artworks.jinya.ListArtworksFragment
import de.jinya.app.login.LoginActivity
import org.jetbrains.anko.*
import org.jetbrains.anko.appcompat.v7.titleResource
import org.jetbrains.anko.appcompat.v7.toolbar
import org.jetbrains.anko.design.navigationView
import org.jetbrains.anko.design.themedAppBarLayout
import org.jetbrains.anko.support.v4.drawerLayout

class MainActivity : AppCompatActivity(), AnkoLogger {
    private val mainView = MainView()

    init {
        if (Debug.isDebuggerConnected()) {
            Picasso.get().setIndicatorsEnabled(true)
        }
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        mainView.setContentView(this)

        val preferences = this.getSharedPreferences(getString(R.string.preference_file_key), Context.MODE_PRIVATE)

        val token = preferences.getString(getString(R.string.api_token), null)
        val jinyaUrl = preferences.getString(getString(R.string.api_base_url), null)

        prepareNavigationDrawer()

        decideAction(token, jinyaUrl)
    }

    private fun decideAction(token: String?, jinyaUrl: String?) {
        if (token == null) {
            if (jinyaUrl != null) {
                FuelManager.instance.apply {
                    basePath = jinyaUrl.toString()
                    baseHeaders = mapOf("Content-Type" to "application/json")
                }
            }
            startActivity<LoginActivity>()
        } else {
            FuelManager.instance.apply {
                basePath = jinyaUrl!!.toString()
                baseHeaders = mapOf("Content-Type" to "application/json", "JinyaApiKey" to token)
            }

            "/api/login".httpHead().response { _, response, _ ->
                if (!response.isSuccessful) {
                    startActivity<LoginActivity>()
                }
            }
        }
    }

    private fun prepareNavigationDrawer() {
        setSupportActionBar(mainView.toolbar)

        val toggle = ActionBarDrawerToggle(
            this,
            mainView.drawer,
            mainView.toolbar,
            R.string.navigation_drawer_open,
            R.string.navigation_drawer_close
        )

        mainView.drawer.addDrawerListener(toggle)
        toggle.syncState()
    }
}

class MainView : AnkoComponent<MainActivity> {
    lateinit var toolbar: Toolbar
    lateinit var drawer: DrawerLayout

    override fun createView(ui: AnkoContext<MainActivity>) = with(ui) {
        drawer = drawerLayout {
            fitsSystemWindows = true
            lparams(width = matchParent, height = matchParent)

            verticalLayout {
                themedAppBarLayout(R.style.ThemeOverlay_AppCompat_Dark_ActionBar) {
                    toolbar = toolbar {
                        lparams(width = matchParent)
                        popupTheme = R.style.AppTheme_PopupOverlay
                        titleResource = R.string.app_name
                    }
                }.lparams(width = matchParent, height = wrapContent)

                frameLayout {
                    id = R.id.nav_main_view
                }.lparams(width = matchParent, height = matchParent)
            }

            navigationView {
                fitsSystemWindows = true
                id = R.id.nav_view

                setNavigationItemSelectedListener {
                    it.isChecked = true
                    lateinit var fragment: Fragment

                    when (it.title) {
                        owner.getString(R.string.nav_art_artworks) -> {
                            fragment = ListArtworksFragment()
                            toolbar.title = owner.getString(R.string.nav_art_artworks)
                        }
                    }

                    val ft = owner.supportFragmentManager.beginTransaction()
                    owner.debug("Starting fragment ${fragment.javaClass.simpleName}")
                    ft.replace(R.id.nav_main_view, fragment)
                    ft.commit()

                    drawer.closeDrawer(START)

                    true
                }

                addHeaderView(NavHeaderView().createView(AnkoContext.Companion.create(ctx, this)))

                menu.apply {
                    addSubMenu(R.string.nav_art).apply {
                        add(R.string.nav_art_artworks)
                        add(R.string.nav_art_videos)
                        add(R.string.nav_art_galleries)
                    }
                    addSubMenu(R.string.nav_static).apply {
                        add(R.string.nav_static_pages)
                        add(R.string.nav_static_forms)
                    }
                    addSubMenu(R.string.nav_configuration).apply {
                        add(R.string.nav_configuration_artists)
                        add(R.string.nav_configuration_frontend)
                    }
                    addSubMenu(R.string.nav_my_account).apply {
                        add(R.string.nav_my_account_account)
                        add(R.string.nav_my_account_two_factor)
                    }
                }
            }.lparams(width = wrapContent, height = matchParent, gravity = START)
        }

        drawer
    }
}

class NavHeaderView : AnkoComponent<NavigationView> {
    override fun createView(ui: AnkoContext<NavigationView>): View = with(ui) {
        themedLinearLayout(R.style.ThemeOverlay_AppCompat_Dark) {
            orientation = LinearLayout.VERTICAL
            gravity = Gravity.BOTTOM
            padding = dimen(R.dimen.nav_header_vertical_spacing)
            backgroundColorResource = R.color.colorPrimary

            imageView(R.mipmap.ic_launcher) {
                topPadding = dimen(R.dimen.nav_header_vertical_spacing)
            }.lparams {
                gravity = Gravity.START
            }
        }
    }
}