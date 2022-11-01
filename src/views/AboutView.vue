<template>
  <v-app>
    <HeadNavigation/>
    <SideNavigation/>

    <v-main>
      <v-container>
        <v-row>
          <v-col>
            <h1>About</h1>
            <p>
              <pre class="text-body-1">
                {{ description }}
              </pre>
            </p>
          </v-col>
        </v-row>
      </v-container>
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
  data: () => ({
    description: `
      Updatemonitor is a new type of release monitoring platform. It brings more flexibility by leveraging Updatecli.\n

      Updatecli is a declarative dependency management tool.
      The people behind the Updatecli project are Open-Source veterans working on many different projects such as Jenkins.\n
      We build Updatecli to make our work easier by automating processes that could be daunting to do manually. This allows us to focus on what matters in our day-to-day work.\n

      Now we use Updatecli to monitor the state of our project to quickly identify version drift.
    `
}),
  components: {
    ReleaseFooter,
    SideNavigation,
    HeadNavigation,
},
}
</script>