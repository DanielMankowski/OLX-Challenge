# OLX-Challenge
Este es un proyecto de ejemplo como parte de una entrevista para la empresa OLX
## Arquitectura del proyecto
Para realizar el proyecto elegí una arquitectura MVC, siempre procurando cumplir con los principios SOLID. Para ello se trata de separar
las responsabilidades de cada pantalla asi como el flujo entre pantallas en diferentes ViewControllers.
Si es de su interés aquí hay un articulo muy interesante al respecto: [A Better MVC](https://davedelong.com/blog/2017/11/06/a-better-mvc-part-1-the-problems/)
## Aspectos técnicos
A los fines de demostrar conocimientos me parecio lo mas adecuado realizar el proyecto de la forma mas nativa posible, por ello voy a
detallar que componentes utilice y que librería podria haber utilizado.
- Para el consumo de la API URLSession y URLSessionTask las mismas se ejecutan en background y implementan cache por default. Podría haber utilizado Alamofire
- Para persistir los datos utilizo el filesystem del dispositivo y los guardo simplemente en un plist, aunque por el tipo de proyecto ya que los items a mostrar
y sus estados (precio/disponibilidad) son variables no parece tener mucho sentido persistir los datos en el dispositivo.
- Para descargar las imágenes use la libreria Nuke, agregada al proyecto mediante CocoaPods.(Cuando descarguen el proyecto deben ejecutar un POD Install localmente)
## Requerimientos cubiertos
Intente cubrir todos los requerimientos solicitados:
- Paginado del contenido
- Detalle del artículo
- Pull to refresh
- Uso de protocolo custom (cuando se selecciona una celda para avisarle al viewcontroller que controla el flow)
- Persistencia en disco
- Cache de imágenes
- Portrait/Landscape
## Aclaraciones/Mejoras
Por razones de tiempo en las pantallas faltan los refresh (UIActivityIndicator) y mostrar mensajes de error si se produce
algun error por ejemplo al consultar la API (UIAlertController).
Tambien se pueden mejorar la collectionview donde se muestran las imagenes, haciendo que se ajuste su tamaño dependiendo de la imagen.
Etc etc etc
