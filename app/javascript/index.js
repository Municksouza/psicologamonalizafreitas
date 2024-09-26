// // Import Stimulus (para gerenciar controladores JS)
// import { Application } from "@hotwired/stimulus";
// import { definitionsFromContext } from "@hotwired/stimulus-webpack-helpers";

// // Inicializar Stimulus
// const application = Application.start();
// const context = require.context("controllers", true, /\.js$/);
// application.load(definitionsFromContext(context));

// // Importar ActionCable para recursos de tempo real (opcional)
// import { createConsumer } from "@rails/actioncable"; // Para WebSockets
// const cable = createConsumer();  // Inicializar ActionCable

// // Defina o canal de comunicação com ActionCable (opcional)
// const channel = cable.subscriptions.create("ChatChannel", {
//   received(data) {
//     console.log(data);  // Apenas um exemplo de como processar as mensagens
//   }
// });
