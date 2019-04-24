clear all
close all
clc

%% SECCIÓN CONFIGURACIÓN DEL PUERTO SERIE
% Borrar todos los instrumentos o conexiones seriales creadas anteriormente
% Que se encuentren en el puerto serie COM8
delete(instrfind({'Port'},{'COM8'}));
% Crear objeto serie
s = serial('COM8', 'BaudRate', 9600,'Terminator','CR/LF');
% Eliminar posibles mensajes de advertencia
warning('off','MATLAB:serial:fscanf:unsuccessfulRead');

% abrir puerto
fopen(s);
% parámetros de medidas
tmax = 20; % tiempo de captura en s
rate = 33; % tasa o velocidad de captura de datos

%% SECCIÓN DE CONFIGURACIÓN DE LA FIGURA A MOSTRAR
% preparar la figura
f = figure('Name','Captura');
a = axes('XLim',[0 tmax],'YLim',[0 5.1]);
l1 = line(nan,nan,'Color','r','LineWidth',2);
l2 = line(nan,nan,'Color','b','LineWidth',2);
xlabel('Tiempo (s)')
ylabel('Voltaje (V)')
title('Joystick por puerto serie')
grid on
hold on

%% BUCLE DE INGRESO DE DATOS
% Iniciar variables
% Vectores para el almacenamiento de los datos
v1 = zeros(1,tmax*rate);
v2 = zeros(1,tmax*rate);
i = 1;
t = 0;

% Ejecutar el bucle
tic  % Iniciar el cronómetro de Matlab
while t < tmax
    % Tiempo de proceso
    t = toc;
    % leer del puerto serie
    a = fscanf(s,'%d')';
    % Almacenar en los vectores ya establecidos
    v1(i)=a(1)*5/1024;
    v2(i)=a(2)*5/1024;
    % Dibujar en la figura ya establecida y configurada
    x = linspace(0,i/rate,i);
    set(l1,'YData',v1(1:i),'XData',x);
    set(l2,'YData',v2(1:i),'XData',x);
    % Mandar a dibujar
    drawnow
    % Incrementar contador
    i = i+1;
end
% resultado del cronometro
clc;
fprintf('%g s de captura a %g capturas/s \n',t,i/t);

%% Limpieza de variables de comunicación serial
fclose(s);
delete(s);
clear s;