% your code here
load('../data/usseq.mat');
frames_total = size(frames,3);
rect_curr = [255; 105; 310; 170];
rect_initial = [255, 105, 310, 170];
rects = zeros(frames_total,4);
rects(1,:) = rect_curr';
rects_correct(1,:) = rect_initial;
frame_print = zeros(1, 6);
time_print = zeros(1, 6);
j = 1;
img = cell(1, 6);
start = tic;
threshold = 10;
for i = 1: frames_total - 1
    [u,v] = LucasKanadeInverseCompositional(frames(:,:,i), frames(:,:,i+1), rect_curr);
    rect_curr = rect_curr + [u; v; u; v];
    rects(i+1, :) = rect_curr';
    rect_curr_correct = rects_correct(i,:);
    [u_correct,v_correct] = LucasKanadeInverseCompositional(frames(:,:,i), frames(:,:,i+1), rect_curr_correct);
    u1 = u_correct;
    v1 = v_correct;
    rects_correct(i+1,:) = rect_curr_correct + [u_correct, v_correct, u_correct, v_correct];
    pinitial = rects_correct(i+1,:) - rect_initial;
    pinitial = [pinitial(1);pinitial(2)];
    [u_new,v_new] = LucasKanadeInverseCompositionalWithCorrection(frames(:,:,1), frames(:,:,i+1), rect_initial,pinitial);
    diff =  [u_new;v_new]- pinitial;
    delta = diff - [u_correct;v_correct];
    if norm(delta) < threshold
        u1 = diff(1);
        v1 = diff(2);
    end
    rects_correct(i+1,:) = rect_curr_correct + [u1, v1, u1, v1];    
    if (i == 5 || i == 25 || i == 50 || i == 75 || i == 100)
        img{j} = insertShape(frames(:,:,i),'Rectangle',[rect_curr(1), rect_curr(2), rect_curr(3) - rect_curr(1), rect_curr(4) - rect_curr(2)], 'LineWidth', 6, 'Color', 'green');
        img1{j} = insertShape(img{j},'Rectangle',[rects_correct(i,1), rects_correct(i,2), rects_correct(i,3) - rects_correct(i,1), rects_correct(i,4) - rects_correct(i,2)], 'LineWidth', 6);
        frame_print(j) = i;
        time_print(j) = toc(start) * 1000;
        j = j + 1;
    end
end
img{j} = insertShape(frames(:,:,100),'Rectangle',[rects(100,1), rects(100,2), rects(100,3) - rects(100,1), rects(100,4) - rects(100,2)], 'LineWidth', 6, 'Color', 'green');
img1{j} = insertShape(img{j},'Rectangle',[rects_correct(100,1), rects_correct(100,2), rects_correct(100,3) - rects_correct(100,1), rects_correct(100,4) - rects_correct(100,2)], 'LineWidth', 6);
j=j+1;        
for i = 1: j-1
    subplot(1,6,i);
    imshow(img1{i});
    title(sprintf('%d (%.3f milliseconds) ', frame_print(i), time_print(i)), 'fontsize', 10);
end
rects = rects_correct;
save('usseqrects-wcrt.mat','rects');