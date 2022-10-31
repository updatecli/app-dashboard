<template>
  <v-app>
    <HeadNavigation/>
    <SideNavigation/>

    <v-main>
      <div class="about">
        <h1>This is an about page</h1>
      </div>
    </v-main>

    <ReleaseFooter/>
  </v-app>
</template>

<script>
import ReleaseFooter from '../components/ReleaseFooter.vue';
import SideNavigation from '../components/SideNavigation.vue';
import HeadNavigation from '../components/HeadNavigation.vue';

export default {
  name: 'DashboardView',
  components: {
    ReleaseFooter,
    SideNavigation,
    HeadNavigation,
},
}
</script>