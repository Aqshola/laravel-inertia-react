import { defineConfig } from 'vite';
import laravel from 'laravel-vite-plugin';

export default defineConfig({
    plugins: [
        laravel({
            input: ['resources/css/app.css', 'resources/js/app.jsx'],
            refresh: true,
        }),
    ],
    server:{
        watch:{
            usePolling:true
        },
        port:3000,
        host:'0.0.0.0',
        hmr: {
            host: 'localhost'
        },
        open:false,
    }
});
