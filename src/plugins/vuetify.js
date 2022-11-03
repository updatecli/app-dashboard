// Styles
import '@mdi/font/css/materialdesignicons.css'
import 'vuetify/styles'

// Vuetify
import { createVuetify } from 'vuetify'

const updatecliTheme = {
  dark: true,
  colors: {
    background: '#FFFFFF',
    surface: '#FFFFFF',
    primary: '#6200EE',
    'primary-darken-1': '#3700B3',
    secondary: '#03DAC6',
    'secondary-darken-1': '#018786',
    error: '#B00020',
    info: '#2196F3',
    success: '#4CAF50',
    warning: '#FB8C00',
  }
}

export default createVuetify({
  theme: {
    //defaultTheme: "dark",
    //defaultTheme: "light",
    defaultTheme: "updatecliTheme",
    themes: {
      updatecliTheme
    }
  }
}
  // https://vuetifyjs.com/en/introduction/why-vuetify/#feature-guides
)
