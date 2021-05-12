function lab_03()
    T = 2.0;
    A = 1.0;
    sigma = 1.0;

    % границы расчета
    borders = 5;
    step = 0.05;
    t = -borders:step:borders;

    % прямоугольный импульс
    function y = rectpls(x,T,A)
        y = zeros(size(x));
        y(abs(x) - T < 0) = A;
    end

    % Гауссов импульс
    function y = gauspls(x,A,s)
        y = A * exp(-(x/s).^2);
    end

    % Генерация импульсов
    x1 = [rectpls(t,T,A) zeros(1,length(t))];
    x2 = [gauspls(t,A,sigma) zeros(1,length(t))];
    x3 = [rectpls(t,T/2,A/2) zeros(1,length(t))];
    x4 = [gauspls(t,A/2,sigma/2) zeros(1,length(t))];

    % Свертка
    % Фурье-образ свертки равен произведению фурье-образов функций
    y1 = ifft(fft(x1).*fft(x2))*step;
    y2 = ifft(fft(x1).*fft(x3))*step;
    y3 = ifft(fft(x2).*fft(x4))*step;

    % Нормализовать свертку
    start = fix((length(y1)-length(t))/2);
    y1 = y1(start+1:start+length(t));
    y2 = y2(start+1:start+length(t));
    y3 = y3(start+1:start+length(t));

    figure(1)
    plot(t, x1(1:201), 'b', t, x2(1:201), 'r', t, y1, 'black');
    title('Прямоугольная и Гауссова свертка');
    legend('Прямоугольный импульс','Гауссов импульс','Свертка');

    figure(2)
    plot(t, x1(1:201), 'b', t, x3(1:201), 'r', t, y2, 'black');
    title('Две прямоугольные свертки');
    legend('Прямоугольный импульс 1','Прямоугольный импульс 2','Свертка');

    figure(3)
    plot(t, x2(1:201), 'b', t, x4(1:201), 'r', t, y3, 'black');
    title('Две Гауссовы свертки');
    legend('Гауссов импульс 1','Гауссов импульс 2','Свертка');
end