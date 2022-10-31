<template>
  <v-app>
    <HeadNavigation/>
    <SideNavigation/>

    <v-main>
      <p>Hello World</p>
    </v-main>

    <ReleaseFooter/>
  </v-app>
</template>

<script>
// @ is an alias to /src
//import HelloWorld from '@/components/HelloWorld.vue'

import ReleaseFooter from '../components/ReleaseFooter.vue';
import SideNavigation from '../components/SideNavigation.vue';
import HeadNavigation from '../components/HeadNavigation.vue';

export default {
  name: 'HomeView',
  components: {
    ReleaseFooter,
    SideNavigation,
    HeadNavigation,
  },
}
</script>
