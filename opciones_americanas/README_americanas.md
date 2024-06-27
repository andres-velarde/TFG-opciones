# Opciones Americanas

Para cada tipo de opciones, Put y Call, pueden encontrarse:

    - Función principal, que devuelve un vector con las aproximaciones al valor de la opción en los puntos (S_i,0) de la malla (put_americana_cn y call_americana_cn)
    
    - Código para el precio, que devuelve una gráfica de la solución proporcionada por la función principal (precios_put_americana y precios_call_americana)
    
    - Código para el precio de opciones europeas y americanas, que grafica el precio de dos opciones de iguales parámetros pero de distinta categoría                         (precios_combinados_put y precios_combinados_call)

    - Función auxiliar que devuelve la matriz completa de la solución, es decir, las aproximaciones a P(S,t) y C(S,t) para todo punto (S_i,t_j) de la malla                     (cn_put_am y cn_call_am)

    - Función de la frontera, que devuelve a partir de la matriz resultante de la función auxiliar la frontra libre (frontera_put y frontera_call)

    - Código para graficar la frontera libre (dibuja_frontera_put y dibuja_frontera_call)

Finalmente, se proporciona también la función precios_binprice que proprociona el valor de la opción americana en los puntos (S_i,0) con el método del árbol binomial de Cox-Ross-Rubinstein.

