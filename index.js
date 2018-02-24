const json = require('./json-dump.js');

document.addEventListener("DOMContentLoaded", () => {
  let body = document.querySelector('body');

  json.forEach((answer_data) => {
    const { answer, count, items } = answer_data;

    const itemsTemplate = (items) => {
      return items.map(itemToTemplate).join('');
    };

    const itemToTemplate = (item) => {
      return `
        <span class="item">
          <h1 class="title">${item.title}</h1>
          <p class="text">${item.text}</p>
        </span>
      `
    };

    let answerContents = `
      <div class="answer-container">
        <h2 class="answer">${answer} - ${count}</h2>
        <div class="items">${itemsTemplate(items)}</div>
      </div>
    `;

    body.insertAdjacentHTML('beforeend', answerContents);
  });
});
