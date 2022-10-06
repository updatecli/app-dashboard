<template>
  <v-app >
    <!---->
    <v-system-bar app>
      <v-spacer></v-spacer>

      <a href="http://github.com/updatecli/updatecli">
        <v-icon size="x-large" >mdi-github</v-icon>
      </a>


      <a href="https://twitter.com/0lblak">
        <v-icon size="x=large">mdi-twitter</v-icon>
      </a>

    </v-system-bar>

    <v-navigation-drawer
      v-model="drawer"
      :rail="rail"
      @click="rail = false"
      permanent
      app >

        <v-list-item
          prepend-avatar="/updatecli.png"
          title="Updatecli"
          nav
        ></v-list-item>

        <v-divider></v-divider>

        <v-list density="compact" nav>
          <v-list-item
            prepend-icon="mdi-home-city"
            link="true"
            title="Dashboard" 
            href="/"
            value="home"></v-list-item>
        </v-list>

    </v-navigation-drawer>

    <!---->
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
      drawer: null,
      links: [
        ['mdi-inbox-arrow-down', 'Inbox'],
        ['mdi-send', 'Send'],
        ['mdi-delete', 'Trash'],
        ['mdi-alert-octagon', 'Spam'],
      ],
  }),
}
</script>
