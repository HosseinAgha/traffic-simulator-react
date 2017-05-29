import { AppContainer } from 'react-hot-loader';
import React from 'react';
import ReactDOM from 'react-dom';
import App from '../App.ls';

/*
  We use JSX here to only demonstrate that we support it ;)
 */

const rootEl = document.getElementById('root');
const render = Component =>
  ReactDOM.render(
    <AppContainer>
      <Component />
    </AppContainer>,
    rootEl
  );

render(App);

if (module.hot) module.hot.accept('../App.ls', () => render(App));
