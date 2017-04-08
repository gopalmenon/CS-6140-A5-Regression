# Function to return the first empty row in a matrix
function [found_row, zero_row] = get_zero_row(query_matrix)

    #Loop at each row
    for row_counter = 1:rows(query_matrix) 
      found_row = true;
      for matrix_element = query_matrix(row_counter,:)
        if matrix_element != 0
          found_row = false
          break
        endif
      endfor
      if (found_row)
        zero_row = row_counter
        break
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
    [found_row, zero_row] = get_zero_row(reduced_matrix)
    
    if (found_row)

    # Replace the zero row with a row from input matrix
      disp(reduced_matrix(zero_row, :));
      reduced_matrix(zero_row, :) = input_matrix(row_counter, :);
    
    else 
    
      [U,S,V] = svd(reduced_matrix);
      S(2*desired_rank,2*desired_rank)
    
    endif
    
    
  
  
  endfor
  
end


load('A.dat')
a=[1,2,3;1,0,1;0,0,0;4,3,1]
frequent_directions(a,1)