function e = difference(I,J,gradJx,gradJy)
e1 = (I-J).*gradJx;
e2 = (I-J).*gradJy;
e1 = sum(sum(e1));
e2 = sum(sum(e2));
e = [e1 e2]';
end

