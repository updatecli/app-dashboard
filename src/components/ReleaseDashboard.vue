<template>
  <v-container
      class="py-8 px-6"
      fluid
  >
      <!--
        Show Dashboard Menu
      -->
    <v-container>
      <v-app-bar
        absolute
        dense
        height="48"
        elevation="0"
      >
        <v-list
          density="compact"
          class="justify-center"
          nav
          width="110"
          >
          <v-list-item
            title="Dashboard"
            >
          </v-list-item>
        </v-list>
        <v-list
          v-for="dashboardInfo in dashboards" :key="dashboardInfo.name"
          density="compact"
          class="justify-center"
          nav
          >
          <v-list-item
            v-if="dashboard.name == dashboardInfo.name"
            :title="dashboardInfo.name"
            :active="true"
            @click="getDashboardData(dashboardInfo.id);"
          ></v-list-item>
          <v-list-item
            v-else
            :title="dashboardInfo.name"
            @click="getDashboardData(dashboardInfo.id);"
          ></v-list-item>
        </v-list>
      </v-app-bar>
    </v-container>
    <v-container v-if="dashboard">
      <v-app-bar
        absolute
        dense
        height="48"
        elevation="0"
        >
        <v-list
          density="compact"
          class="justify-center"
          nav
          width="110"
          >
          <v-list-item
            title="Project"
            >
          </v-list-item>
        </v-list>
        <v-list
          v-for="project in dashboard.projects" :key="project.name"
          density="compact"
          class="justify-center"
          nav
          >
          <v-list-item
            v-if="currentProject.name == project.name"
            :title="project.name"
            :active="true"
            @click="setCurrentProject(project)"
          ></v-list-item>
          <v-list-item
            v-else
            :title="project.name"
            @click="setCurrentProject(project)"
          ></v-list-item>
        </v-list>
      </v-app-bar>
    </v-container>

    <!-- Show Project Description -->
    <v-container
      v-if="currentProject"
      >
      <v-row 
        class="mx-auto">
        <v-col
            cols="auto"
            lg="12"
            md="12"
            sm="12"
          >
          <v-card
            elevation="1"
            shaped
            outline
            >
            <v-card-title>
              {{ currentProject.name }}
            </v-card-title>
            <v-card-text >
              <p>{{ currentProject.description }}</p>
            </v-card-text>
          </v-card>
        </v-col>
      </v-row>
      <!--
        Show Project application in a table
      -->
      <v-row>
        <v-col
            cols="auto"
            lg="12"
            md="12"
            sm="12"
          >

          <v-table
            density="compact"
            fixed-header
            max-height="600px"
          >
            <thead>
              <tr>
                <th class="text-left">
                  Status
                </th>
                <th class="text-left">
                  Name
                </th>
                <th class="text-left">
                  Description
                </th>
                <th class="text-left">
                  Apps
                </th>
                <th class="text-left">
                </th>
              </tr>
            </thead>
            <tbody>
              <tr
                v-for="item in currentProject.apps"
                :key="item.name"
              >
                <td><v-icon :icon=getStatusIcon(item.status) :color=getStatusColor(item.status)></v-icon></td>
                <td>{{ item.name }}</td>
                <td>{{ item.description }}</td>
                <td>
                  <v-btn
                    rounded
                    density="compact"
                    small
                    v-for="spec in item.spec"
                      :key="spec.name"
                      >
                    {{ spec.version }}
                  </v-btn>
                </td>
                <td>
                  <v-chip
                    class="ma-2"
                    @click="app=item"
                  >
                    Details
                  </v-chip>
                </td>
              </tr>
            </tbody>
          </v-table>
        </v-col>
      </v-row>
      <v-row>
        <v-col
            cols="auto"
            lg="12"
            md="12"
            sm="12"
          >
          <v-card
            v-if="app"
            elevation="5"
            shaped
            outline
            >
              <v-card-title>{{ app.name }}</v-card-title>
              <v-card-text>
                <p>{{ app.description }}</p>
              </v-card-text>
              <v-card-text>
                <p>{{ app.updatedAt }}</p>
              </v-card-text>
          </v-card>
        </v-col>
        <v-col
            cols="auto"
            lg="12"
            md="12"
            sm="12"
          >
          <v-row>
            <v-col
              v-for="spec in app.spec"
              :key="spec.name"
              cols="auto"
              lg="12"
              md="12"
              sm="12"
            >
              <v-card
                :border="true"
                variant="outlined"
              >
                <v-card-title>
                  <v-row
                    align-center="center"
                    >
                    <v-col>
                      {{ spec.name }}
                    </v-col>
                    <v-col
                      class="text-right"
                    >
                      <v-btn
                        class="justify-end"
                        rounded
                        density="compact"
                        small
                          >
                        {{ spec.version }}
                      </v-btn>
                    </v-col>
                  </v-row>
                </v-card-title>
                  <v-expansion-panels
                  >
                    <v-expansion-panel
                      title="Description"
                      :text="spec.description"
                    >
                    </v-expansion-panel>
                    <v-expansion-panel
                      class="text-body-1"
                      title="Changelog"
                      :text="spec.changelog"
                      tag="pre"
                    >
                    </v-expansion-panel>
                    <v-expansion-panel
                      class="text-body-1"
                      title="Updatecli Manifest"
                      :text="spec.updatemanifest"
                      tag="pre"
                    >
                    </v-expansion-panel>
                  </v-expansion-panels>
              </v-card>
            </v-col>
          </v-row>
        </v-col>
      </v-row>
    </v-container>

        <!-- -->

          <!-- Disable for now the vue card
          For each project, show apps information

      <v-row v-for="project in getDashboard.projects"
              :key="project.name">
          <v-col
              cols="auto"
              lg="12"
              md="12"
              sm="12"
            >

          Show Project Description
          <v-row class="mx-auto">
            <v-col
                cols="auto"
                lg="12"
                md="12"
                sm="12"
              >
                <v-card
                  elevation="3"
                  shaped
                  outline
                  >
                  <v-card-title align="center">{{ project.name }}</v-card-title>
                  <v-card-text align="center">
                    <p>{{ project.description }}</p>
                  </v-card-text>
                </v-card>
            </v-col>
          </v-row>


          <v-row class="mx-auto">
              <v-col
                  v-for="app in project.apps"
                  :key="app.name"
                  cols="auto"
                  lg="4"
                  md="12"
                  sm="12"
              >
                <v-card
                  elevation="3"
                  shaped
                  outline
                  min-height="300"
                  >
                  <v-card-title align="center">
                    <v-icon :icon=getStatusIcon(app.status) :color=getStatusColor(app.status)></v-icon>
                    {{ app.name}}</v-card-title>

                  <v-row>
                    <v-col>
                      <v-card-text align="center">
                        {{ app.description}}
                      </v-card-text>
                    </v-col>
                  </v-row>

                    <v-row>
                      <v-col
                        v-for="spec in app.spec"
                        :key="spec.name"
                        cols="auto"
                        lg="6"
                        md="12"
                        sm="12"
                      >
                        <v-card-title align="center">{{ spec.name }}</v-card-title>
                        <v-card-text align="center">{{ spec.version }}</v-card-text>
                        <v-card-text align="center">{{ spec.description }}</v-card-text>
                      </v-col>
                      </v-row>
                  <v-row>
                    <v-col>
                      <v-card-text align="center">Updated At</v-card-text>
                      <v-card-subtitle align="center">
                      {{ app.updatedAt}}
                      </v-card-subtitle>
                    </v-col>
                  </v-row>
                </v-card>
              </v-col>
          </v-row>

        </v-col>
      </v-row>
      -->

  </v-container>
</template>

<script>
import axios from 'axios'

export default {
  name: 'ReleaseDashboard',

  data: () => ({
    app: [],
    dashboard: [],
    dashboards: [],
    currentProject: [],
  }),

  computed: {
    getDashboard: function() {
      return this.dashboard
    },
  },

  beforeUnmount() {
    this.cancelAutoUpdate();
  },

  methods: {
    cancelAutoUpdate() {
      clearInterval(this.timer);
    },
    getDashboardData(id) {
      try {
        axios.get("/api/dashboards/" + id).then(response => {
              this.dashboard = response.data.data
          });
        //this.timer = setInterval(this.getDashboardData(id), 300000)
      } catch (error){
        this.dashboard = [];
        console.log(error);
      }
      return this.dashboard;
    },
    setCurrentProject(project) {
      this.currentProject = project;
    },
    getStatusColor: function(status){
      switch (status) {
        case 2:
          return "success"
        case 3:
          return "red"
        case 4:
          return "orange"
        default:
          return "mdi-robot-off"
      }
    },
    getStatusIcon: function(status){
      switch (status) {
        case 2:
          return "mdi-robot-love"
        case 3:
          return "mdi-robot-angry"
        case 4:
          return "mdi-robot-confused"
        default:
          return "mdi-robot-off"
      }
    },

  },

  async created() {
    try {
      const dashboards = await axios.get(`/api/dashboards`);
      this.dashboards = dashboards.data.data;
      this.getDashboardData(this.dashboards[0]["id"])

      // for some reason the following line the wrong value to currentProject
      this.setCurrentProject(this.dashboard.projects[0])

    } catch (error) {
      console.log(error);
    }
  },
}
</script>
