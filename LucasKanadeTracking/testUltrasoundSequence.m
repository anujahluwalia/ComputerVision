% your code here
load('../data/usseq.mat');
frames_total = size(frames,3);
rect_curr = [255; 105; 310; 170];
rects = zeros(frames_total,4);
rects(1,:) = rect_curr';
frame_print = zeros(1, 5);
time_print = zeros(1, 5);
j = 1;
img = cell(1, 5);
start = tic;
for i = 1: frames_total-1
    [u,v] = LucasKanadeInverseCompositional(frames(:,:,i), frames(:,:,i+1), rect_curr);
    rect_curr = rect_curr + [u; v; u; v];
    rects(i+1, :) = rect_curr';
    if (i == 5 || i == 25 || i == 50 || i == 75 || i == 100)
        img{j} = insertShape(frames(:,:,i),'Rectangle',[rect_curr(1), rect_curr(2), rect_curr(3) - rect_curr(1), rect_curr(4) - rect_curr(2)], 'LineWidth', 6);
        frame_print(j) = i;
        time_print(j) = toc(start) * 1000;
        j = j + 1;
    end     
end
img{j} = insertShape(frames(:,:,100),'Rectangle',[rects(100,1), rects(100,2), rects(100,3) - rects(100,1), rects(100,4) - rects(100,2)], 'LineWidth', 6);
frame_print(j) = 100;
time_print(j) = toc(start) * 1000;
j = j + 1;
for i = 1: j-1
    subplot(1,5,i);
    imshow(img{i});
    title(sprintf('%d (%.3f milliseconds) ', frame_print(i), time_print(i)), 'fontsize', 10);
end
save('usseqrects.mat','rects');