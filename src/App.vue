<template>
  <v-app>
    <v-system-bar window app>
      <v-btn icon="mdi-github"  variant="text" href="https://github.com/updatecli/app-dashboard" ></v-btn>
      <v-btn icon="mdi-twitter"  variant="text" href="https://twitter.com/updatecliio" ></v-btn>
    </v-system-bar>


    <v-navigation-drawer
      v-model="drawer"
      expand-on-hover
      permanent
      rail
      bottom
      app>

        <v-list-item
          height="48"
          prepend-avatar="/updatecli.png"
          title="Menu"
          nav
        ></v-list-item>

        <v-divider></v-divider>

        <v-list density="compact" nav>
          <v-list-item
            prepend-icon="mdi-home-city"
            title="Dashboards"
            href="/"
            value="home"></v-list-item>
        </v-list>

    </v-navigation-drawer>

    <v-main>
      <ReleaseDashboard/>
    </v-main>
  </v-app>
</template>

<script>
import ReleaseDashboard from './components/ReleaseDashboard.vue';

export default {

  name: 'App',

  components: {
    ReleaseDashboard,
},

  data: () => ({
      drawer: true,
  }),
}
</script>
