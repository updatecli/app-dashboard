<template>
  <v-container
      class="py-8 px-6"
      fluid
  >
      <v-container
        max-height="100"
        >
        <v-row>
          <v-col
            class="text-right"
            cols="auto"
            lg="8"
            md="8"
            sm="12"
          >
          <h1>
            Dashboards
          </h1>
          </v-col>
        </v-row>

        <v-row>
          <v-col
            class="text-right"
            cols="auto"
            lg="8"
            md="8"
            sm="12"
          >
            <p>
            Dashboards allow to visualize version information
            </p>
            <p>
            First, pick a dashboard
            </p>
            <p>
            Then a project within that dashboard
            </p>
            <p>
            Finally, you can detailed application information
            </p>
          </v-col>
          <v-col
            class="text-left"
            cols="auto"
            lg="2"
            md="2"
            sm="12"
            >
            <div
              v-for="dashboardInfo in dashboards" :key="dashboardInfo.name"
              >
              <v-btn
                v-if="dashboard.name == dashboardInfo.name"
                @click="setCurrentDashboardID(dashboardInfo.id)"
                class="mx-4"
                variant="text"
                :active="true"
                prepend-icon="mdi-arrow-right-circle"
                >
                {{ dashboardInfo.name }}
              </v-btn>
              <v-btn
                v-else
                @click="setCurrentDashboardID(dashboardInfo.id)"
                class="mx-4"
                variant="text"
                prepend-icon="mdi-arrow-right-circle-outline"
                >
                {{ dashboardInfo.name }}
              </v-btn>
            </div>
          </v-col>
          <v-col
            class="text-left"
            v-if="dashboard"
            cols="auto"
            lg="2"
            md="2"
            sm="12"
            >
            <div
              v-for="project in dashboard.projects" :key="project.name"
              >
              <v-btn
                v-if="currentProject.name == project.name"
                @click="setCurrentProject(project)"
                class="mx-4"
                variant="text"
                :active="true"
                prepend-icon="mdi-circle"
                >
                {{ project.name }}
              </v-btn>
              <v-btn
                v-else
                @click="setCurrentProject(project)"
                class="mx-4"
                variant="text"
                prepend-icon="mdi-circle-outline"
                >
                {{ project.name }}
              </v-btn>
            </div>
          </v-col>
        </v-row>
      </v-container>

    <!-- Show Project Description -->
    <v-container v-if="currentProject">
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
            :flat=true
            shaped
            outline
            >
            <v-row>
              <v-col
                  cols="auto"
                  lg="12"
                  md="12"
                  sm="12"
              >
                <v-card
                  :flat=true
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
            </v-row>
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
          </v-card>
        </v-col>
      </v-row>
    </v-container>
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
    currentProject: '',
    currentDashboardID: '',
  }),

  beforeUnmount() {
    this.cancelAutoUpdate();
  },

  watch: {
    currentDashboardID(newID){
      // No need to qery API if if ID is empty
      if (newID == '') {
        return
      }
      try {
        axios.get("/api/dashboards/" + newID).then(response => {
              this.dashboard = response.data.data
          });
        this.timer = setInterval(this.getDashboardData(newID), 60)
      } catch (error){
        this.dashboard = [];
      }
    }
  },

  methods: {
    cancelAutoUpdate() {
      clearInterval(this.timer);
    },
    setCurrentProject(project) {
      this.currentProject = project;
      this.app = '';
      return this.currentProject;
    },
    setCurrentDashboardID(id) {
      this.currentDashboardID = id;
      this.currentProject = '';
      this.app = '';
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
    } catch (error) {
      console.log(error);
    }

  },
}
</script>
