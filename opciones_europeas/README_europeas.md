# Opciones Europeas

Para cada tipo de opciones, Put y Call, pueden encontrarse:

    - Funciones principales por cada esquema numérico, que devuelve un vector con las aproximaciones al valor de la opción en los puntos de la malla en S     
      con el explícito (put_europea_explicito y call_europea_ecplicito), el implicito (put_europea_implicito y call_europea_implicito) y el de Crank-Nicolson 
      (put_europea_cn y call_europea_cn)
    
    - Códigos para el precio según el esquema numérico, que devuelven una gráfica de la solución proporcionada por las funciones principales con el explícito 
      (precio_ecplicito_put y precio_explicito_call), el implicito (precio_implicito_put y precio_implicito_call) y el de Crank-Nicolson (precio_cn_put y 
      precio_cn_call)
    
Finalmente, se incluye también el algoritmo de Thomas para matrices tridiagonales utilizado en tridiagonal_matrix de 22/10/2022 (Copyright © 2021 Tamas Kis, https://tamaskis.github.io)
