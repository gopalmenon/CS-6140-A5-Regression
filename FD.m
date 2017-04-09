# Function to return the first empty row in a matrix
function [found_row, zero_row] = get_zero_row(query_matrix)

    #Loop at each row
    zero_row = 0;
    for row_counter = 1:rows(query_matrix) 
      found_row = true;
      for matrix_element = query_matrix(row_counter,:)
        if matrix_element != 0
          found_row = false;
          break;
        endif
      endfor
      if (found_row)
        zero_row = row_counter;
        break;
      endif
    endfor

end

# Function to return a matrix that has reduced dimensionality
# using the Frequent Directions algorithm
# Parameters:
# 1. Matrix to be dimensionally reduced
# 2. Desired rank for reduced matrix
function [reduced_matrix] = frequent_directions(input_matrix, desired_rank)
  
  [input_rows, input_dimensions] = size(input_matrix);

  # Initialize return value with zeros
  reduced_matrix = zeros(desired_rank, input_dimensions);

  # Repeat for each row in input matrix
  for row_counter = 1:rows(input_matrix)
    
    # Look for a row in the reduced matrix with all zeros
    [found_row, zero_row] = get_zero_row(reduced_matrix);

    # Replace the zero row with a row from input matrix
    reduced_matrix(zero_row, :) = input_matrix(row_counter, :);
    
    # Check if reduced matrix has any empty rows
    [found_row, zero_row] = get_zero_row(reduced_matrix);
    
    if (!found_row)
    
      # Singular value decomposition
      [U,S,V] = svd(reduced_matrix);

      if (S(min(input_dimensions,desired_rank), min(input_dimensions,desired_rank)) != 0)
      
        last_eigen_value =  S(min(input_dimensions,desired_rank), min(input_dimensions,desired_rank)) ^ 2;
        new_singular_matrix = zeros(size(S));
      
        # Change each singular value
        for singular_value_counter = 1:min(input_dimensions,desired_rank)
          new_singular_matrix(singular_value_counter, singular_value_counter) = sqrt(S(singular_value_counter, singular_value_counter)^2 - last_eigen_value);
        endfor

        # Reduce the matrix
        reduced_matrix =  new_singular_matrix * V.';

        endif
        
    endif
  
  endfor
  
end

# Return k approximation of input matrix
function [best_k_approximation] = get_best_k_approximation(input_matrix, k)

  [U,S,V] = svd(input_matrix);
  Uk = U(:,1:k);
  Sk = S(1:k,1:k);
  Vk = V(:,1:k);
  best_k_approximation = Uk*Sk*Vk';

end

#cd data;
load('A.dat');
#A=[1,2,3;0,0,0;5,6,7;9,7,4];
B= frequent_directions(A,10);
norm(A'*A - B'*B, 2)
(norm(A - get_best_k_approximation(A, 2),"fro")^2)/10