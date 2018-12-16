---
title: Compyler. Un traductor de lenguaje natural a Python para listas
author: |
		| Vladislav Nikolov Vasilev
		| Nazaret Román Guerrero
theme: Copenhagen
header-includes: |
	
	\setbeamertemplate{footline}
	{%
	  \leavevmode%
	  \hbox{\begin{beamercolorbox}[wd=.1\paperwidth,ht=2.5ex,dp=1.125ex,leftskip=.3cm,rightskip=.3cm plus1fill]{author in head/foot}%
		\usebeamerfont{author in head/foot} \insertframenumber{}/\inserttotalframenumber
	  \end{beamercolorbox}%
	  \begin{beamercolorbox}[wd=.4\paperwidth,ht=2.5ex,dp=1.125ex,leftskip=.3cm plus1fill,rightskip=.3cm]{author in head/foot}%
		\usebeamerfont{author in head/foot}\insertshortauthor
	  \end{beamercolorbox}%
	  \begin{beamercolorbox}[wd=.5\paperwidth,ht=2.5ex,dp=1.125ex,leftskip=.2cm,rightskip=.2cm plus1fil]{title in head/foot}%
		\usebeamerfont{title in head/foot}\insertshorttitle
	  \end{beamercolorbox}}%
	  \vskip0pt%
	}
---

# Variables y alias
\begin{center}
	\includegraphics[width=0.7\textwidth]{variables-alias.png}
\end{center}

# Funcionalidades (I)
![Expresiones para crear una lista y obtener la longitud.](crear-longitud.png)

# Funcionalidades (II)
![Expresiones para imprimir y recorrer una lista.](imprinir-recorrer.png)

# Funcionalidades (III)
![Expresiones para insertar, borrar y obtener un elemento de una lista.](insertar-borrar-obtener.png)

# Funcionalidades (IV)
![Expresiones para copiar, concatenar y ordenar listas.](copiar-concatenar-odenar.png)

# Funcionalidades (V)
![Expresiones para sumar y comparar listas.](suma-comparar.png)

# Funcionalidades (VI)
![Expresiones para procesar un operador, una variable, mostrar el resultado de una comparación y regla por defecto.](operador-variable-mostrarcomp.png)

# Ejemplo: salida por defecto
![Salida por pantalla de la funcionalidad.](ejemplo.png)

# Ejemplo: salida a un archivo .py
![Salida redirigida a un archivo .py y ejecutado en python.](ejemplo-python.png)
