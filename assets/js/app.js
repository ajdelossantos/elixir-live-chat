// We need to import the CSS so that webpack will load it.
// The MiniCssExtractPlugin is used to separate it out into
// its own CSS file.
import css from '../css/app.css';

// webpack automatically bundles all modules in your
// entry points. Those entry points can be configured
// in 'webpack.config.js'.
//
// Import dependencies
//
import 'phoenix_html';

// Import local files
//
// Local files can be imported directly using relative paths, for example:
// import socket from './socket'

import LiveSocket from 'phoenix_live_view';

let Hooks = {};

Hooks.NewMessage = {
  mounted() {
    let messages = document.querySelector('.main');
    let currentScrollHeight = messages.scrollTop + messages.offsetHeight + this.el.offsetHeight;

    if (currentScrollHeight >= messages.scrollHeight) messages.scrollTop = messages.scrollHeight;
  }
};

let liveSocket = new LiveSocket('/live', {hooks: Hooks});
liveSocket.connect();
