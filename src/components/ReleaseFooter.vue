<template>
    <v-footer
        class="text-center d-flex flex-column"
        app
        bottom
        fixed
        padless
    >
        <div>
            <v-btn class="mx-4" icon="mdi-github"  variant="text" href="https://github.com/updatecli"></v-btn>
            <v-btn class="mx-4" icon="mdi-twitter" variant="text" href="https://twitter.com/0lblak"></v-btn>
            <v-btn class="mx-4" icon="mdi-mastodon" variant="text" href="https://fosstodon.org/@olblak"></v-btn>
            <v-btn class="mx-4" icon="mdi-linkedin" variant="text" href="https://www.linkedin.com/in/overnin/"></v-btn>
        </div>
        <div>
            {{ new Date().getFullYear() }} — <strong>© Vernin Olivier</strong>
        </div>
    </v-footer>
</template>

<script>
    export default {
        name: "ReleaseFooter",
    }
</script>