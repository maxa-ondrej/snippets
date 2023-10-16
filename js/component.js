import { html, render } from 'https://unpkg.com/lit-html@2.8.0?module';

/**
 * @param {HTMLCustomElement} element
 */
function parseProps(element) {
  const props = {};
  element.getAttributeNames().forEach(n => {
    props[n] = element.getAttribute(n);
  });
  return props;
}

class HTMLCustomElement extends HTMLElement {
  /**
   * Constructor
   * @param {string} name name of the custom element
   * @param {*} template html template
  */
  constructor(name, template) {
    super();
    this.attachShadow({ mode: "open" });
    const props = parseProps(this);
    render(
      html`
      <style>@import "/assets/css/${name}.min.css";</style>
      ${template(props)}
      `,
      this.shadowRoot);
  }
}

async function loadComponent([name, component]) {
  window.customElements.define(name, class extends HTMLCustomElement {
      constructor() {
        super(name, component.default);
        (component.listeners ?? [])
          .forEach(([ event, query, callback ]) => {
            this.shadowRoot.querySelector(query).addEventListener(event, callback);
          });
      }
    });
}

Object.entries(window.components)
  .map(loadComponent)
  .forEach(p => p.catch(console.error));

