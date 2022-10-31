<template>
    <v-footer
        class="text-center d-flex flex-column"
    >
        <div>
            <v-btn class="mx-4" icon="mdi-github"  variant="text" href="https://github.com/updatecli/app-dashboard"></v-btn>
            <v-btn class="mx-4" icon="mdi-twitter" variant="text" href="https://twitter.com/updatecliio"></v-btn>
        </div>
        <div>
            {{ new Date().getFullYear() }} — <strong>Olblak</strong>
        </div>
    </v-footer>
</template>

<script>
    export default {
        name: "ReleaseFooter",
    }
</script>