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
  reduced_matrix = zeros(2*desired_rank, input_dimensions);

  # Repeat for each row in input matrix
  for row_counter = 1:rows(input_matrix)
    
    # Look for a row in the reduced matrix with all zeros
    [found_row, zero_row] = get_zero_row(reduced_matrix);
    
    if (found_row)

      # Replace the zero row with a row from input matrix
      reduced_matrix(zero_row, :) = input_matrix(row_counter, :);
    
    else 
    
      [U,S,V] = svd(reduced_matrix);
      size(S)
      if (S(2*desired_rank,2*desired_rank) != 0)
      
        last_eigen_value =  S(2*desired_rank,2*desired_rank) ^ 2;
        new_singular_matrix = zeros(size(S));
      
        # Change each singular value
        for singular_value_counter = 1:input_dimensions
        
          new_singular_matrix(singular_value_counter, singular_value_counter) = sqrt(S(singular_value_counter, singular_value_counter)^2 - last_eigen_value);
      
      
        endfor
        reduced_matrix =  new_singular_matrix * V.';
      endif
    endif
  
  endfor
  
end

#cd data;
load('A.dat');
#A=[1,2,3;0,0,0;5,6,7;9,7,4];
B= frequent_directions(A,500);
norm(A'*A - B'*B, 2)