% your code here
load('../data/sylvseq.mat');
load('../data/sylvbases.mat');
frames_total = size(frames,3);
rect_curr = [102; 62; 156; 108];
rects = zeros(frames_total,4);
rects(1,:) = rect_curr';
rect_curr1 = [102; 62; 156; 108];
rects1 = zeros(frames_total,4);
rects1(1,:) = rect_curr1';
frame_print = zeros(1, 5);
time_print = zeros(1, 5);
j = 1;
img = cell(1, 5);
start = tic;
for i = 1: frames_total-1
    [u,v] = LucasKanadeBasis(frames(:,:,i), frames(:,:,i+1), rect_curr,bases);
    rect_curr = rect_curr + [u; v; u; v];
    rects(i+1, :) = rect_curr';
    [u1,v1] = LucasKanadeInverseCompositional(frames(:,:,i), frames(:,:,i+1), rect_curr1);
    rect_curr1 = rect_curr1 + [u1; v1; u1; v1];
    rects1(i, :) = rect_curr1';
    if (i == 1 || i == 200 || i == 300 || i == 350 || i == 400)
        img{j} = insertShape(frames(:,:,i),'Rectangle',[rect_curr(1), rect_curr(2), rect_curr(3) - rect_curr(1), rect_curr(4) - rect_curr(2)], 'LineWidth', 3);
        img1{j} = insertShape(img{j},'Rectangle',[rect_curr1(1), rect_curr1(2), rect_curr1(3) - rect_curr1(1), rect_curr1(4) - rect_curr1(2)], 'Color', 'green');
        frame_print(j) = i;
        time_print(j) = toc(start) * 1000;
        j = j + 1;
    end 
    
end
for i = 1: j-1
    subplot(1,5,i);
   % imshow(img{i});
    imshow(img1{i});
    title(sprintf('%d (%.3f milliseconds) ', frame_print(i), time_print(i)), 'fontsize', 10);
end
save('sylvseqrects.mat','rects');