function ranking = get_ranking(numbers)
    [~, order] = sort(numbers, 'descend');
    [~, ranking] = sort(order);
end
