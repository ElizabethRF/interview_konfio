---


---

<h1 id="interview_konfio">interview_konfio</h1>
<p>Prueba de Evaluación Data Engineer<br>
Objetivo:<br>
Generar SQLs que proporcionen la información requerida a partir de las tablas y datos dados.</p>
<p>Características:<br>
Utilizando una base de datos. Elige aquella con la que te sientas cómodo trabajando:<br>
PostgreSQL, Oracle, SQL Server, Mysql, MariaDB, etc</p>
<p>• Crea las tablas customer, loan, payment, loan_type utilizando los<br>
archivos.sql<br>
• Inserta los datos de los archivos .csv en las tablas creadas.</p>
<p>Preguntas:<br>
Utilizando las tablas y datos creados obtener mediante consultas de SQL:</p>
<ol>
<li>
<p>Porcentajes de préstamos completados y préstamos no completados<br>
segmentados por genero y año.</p>
</li>
<li>
<p>El préstamo más alto que se haya dado segmentado por mes junto con el<br>
promedio que se prestó durante el año 2017, ejemplo:</p>
</li>
</ol>
<p><img src="https://lh3.googleusercontent.com/IIlr2hok1AtfYClzoQ1klJCyA9051Io99sHgBPI3KFr8Fg0jVvZ92-QD2G8VFcvqtg8qWTbqcEXpNA" alt="enter image description here"></p>
<ol start="3">
<li>Los nombres, edad, y número de préstamo de aquellos clientes que hayan<br>
pagado más de la cantidad que se les haya prestado inicialmente.</li>
<li>Los números de préstamos cuyos pagos tengan un payment_number duplicado.</li>
<li>La cantidad de préstamos de cada mes, agrupados por tipo. Al ejecutarse el<br>
output debe verse en la siguiente forma:</li>
</ol>
<p><img src="https://lh3.googleusercontent.com/lu8ur6ARHAl9WHk4uXGdAMnfFKMTMzlZ-p3JFjpqlYzlQMr4epZScIh2b2jmRITZAOJkUcHAitfoHw" alt="enter image description here"></p>
<hr>
<p>Los siguientes son bonus points en orden de importancia (Los más<br>
importantes hasta abajo):</p>
<ol start="6">
<li>
<p>Obtener un reporte de aquellos pagos cuyo payment_number no fue asignado correctamente (los números de los pagos deben comenzar en 1 y ser<br>
consecutivos)</p>
</li>
<li>
<p>Obtener un reporte de aquellos préstamos que incorrectamente han sido<br>
marcados como completados o no completos. Así como la cantidad sobrante o<br>
faltante según sea el caso.</p>
</li>
<li>
<p>Generar un procedure que corrija la información obtenida en los puntos<br>
anteriores</p>
</li>
<li>
<p>Generar la corrección en lenguaje python. Incluir en un archivo config.ini los<br>
datos de conexión a la base de datos.</p>
</li>
<li>
<p>Cualquier funcionalidad adicional. ¡Sorpréndenos!</p>
</li>
</ol>

Entregables:<br>
• DDL File (.sql o su equivalente)</p>
<p>• Bonus: Subir el proyecto a tu cuenta personal de repo hosting (github, gitlab, etc.)</p>
<p>Entrega: 72 horas después de recibida la prueba (Bonus points si es entregado<br>
antes de 36 hrs. )</p>

