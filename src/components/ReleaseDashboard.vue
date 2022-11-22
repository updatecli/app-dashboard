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
            class="text-center"
          >
          <h1>
            Dashboards
          </h1>
          </v-col>
        </v-row>
        <v-row>
          <v-col
            class="text-center"
            >
            <v-btn-toggle
              v-model="toggle_exclusive"
              divided rounded="xl"
              variant="outlined"
            >
            <div
              class="d-flex align-center flex-column"
              v-for="dashboardInfo in dashboards" :key="dashboardInfo.name"
              >
                <v-btn
                  @click="setCurrentDashboardID(dashboardInfo.id)"
                  variant="text"
                  size="x-large"
                  >
                  {{ dashboardInfo.name }}
                </v-btn>
            </div>
            </v-btn-toggle>
          </v-col>
        </v-row>
      </v-container>

    <!-- Show Project Description -->
    <v-container v-if="currentDashboardID">
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
                  Project
                </th>
                <th class="text-left">
                  Application
                </th>
                <th class="text-left">
                  Created At
                </th>
                <th class="text-left">
                  Updated At
                </th>
                <th class="text-left">
                  Apps
                </th>
                <th class="text-left">
                </th>
              </tr>
            </thead>
            <tbody
              v-for="project in dashboard.projects" :key="project.name"
              >
              <tr
                v-for="item in project.apps"
                :key="item.name"
              >
                <td><v-icon :icon=getStatusIcon(item.status) :color=getStatusColor(item.status)></v-icon></td>
                <td>{{ project.name }}</td>
                <td>{{ item.name }}</td>
                <td>{{ item.createdAt }}</td>
                <td>{{ item.updatedAt }}</td>
                <td>
                  <v-btn-toggle
                  >
                    <v-btn
                      rounded
                      density="compact"
                      small
                      v-for="spec in item.spec"
                        :key="spec.name"
                        >
                      {{ spec.version }}
                    </v-btn>
                  </v-btn-toggle>
                </td>
                <td>
                  <v-chip
                    @click="app=item;currentProject=project"
                    v-if="app.name == item.name"
                    append-icon="mdi-arrow-down-circle"
                  >
                  </v-chip>
                  <v-chip
                    v-else
                    @click="app=item;currentProject=project"
                    append-icon="mdi-arrow-right-circle"
                  >
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
                  <v-card-title>Project: {{ currentProject.name }}</v-card-title>
                  <v-card-text>
                    <p>{{ currentProject.description }}</p>
                  </v-card-text>
                </v-card>
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
                  :flat=true
                >
                  <v-card-title>Application: {{ app.name }}</v-card-title>
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
