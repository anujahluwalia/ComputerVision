% your code here
load('../data/usseq.mat');
load('./usseqrects.mat');
frames_total = size(frames,3);
j=1;
for i = 1:frames_total-1
    image1 = frames(:,:,i);
    image2 = frames(:,:,i+1);
    if (i == 5 || i == 25 || i == 50 || i == 75 || i == 100)
      mask = SubtractDominantMotion(image1, image2);
      test = zeros(size(mask,1),size(mask,2));
      for m = 1:size(mask,1)
        for n = 1:size(mask,2)
            if ((n > rects(i,1)) && (n < rects(i,3)) && (m > rects(i,2)) && (m < rects(i,4)))
                test(m,n) = 1;
            end
        end
      end
      mask = mask .* test;
      img{j} = imfuse(image1,mask,'ColorChannels',[1 2 0]);
      frame_print(j) = i;
      j = j+1;
    end
end
img{j} = imfuse(image1,mask,'ColorChannels',[1 2 0]);
frame_print(j) = i;
j = j+1;
for i = 1: j-1
    subplot(1,5,i);
    imshow(img{i});
    title(sprintf('%d ', frame_print(i)), 'fontsize', 10);
end
