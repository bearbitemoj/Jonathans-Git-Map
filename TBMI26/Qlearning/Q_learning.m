function Q = Q_learning(Q, alpha, gamma, epsilon,not_valid_penalty,...
            episode, numberOfEpisodes, drawEpisodes, probability_vector)
%Q_LEARNING calculates the Q-function
%   alpha: learning rate
%   gamma: discount factor
%   epsilon: exploration factor. Explore a lot (large epsilon) and
%   focus the search more around the good policies (small epsilon).
%   reward: reward for reaching the goal
%   not_valid_penalty: penalty for when an action is not valid
%   episode: training iteration
%   numberOfEpisodes: number of iterations to train
%   drawEpisodes: number of episodes to be drawn

while true
    state = gwstate;
    state_x = state.pos(1);
    state_y = state.pos(2);
    
    while true
        [action, ~] = chooseaction(Q,state_x,state_y,[1 2 3 4],...
                                  probability_vector, epsilon);

        new_state = gwaction(action);
        new_state_x = new_state.pos(1);
        new_state_y = new_state.pos(2);
        reward = new_state.feedback;
        
        if new_state.isvalid == 1
            break;
        elseif not_valid_penalty < 0
            Q(state_x,state_y,action) = not_valid_penalty;
        end
    end
    
    Q(state_x,state_y,action) = (1-alpha)*Q(state_x,state_y,action) + ...
    alpha*(reward + gamma*max(Q(new_state_x,new_state_y,:)));
    
    if episode > (numberOfEpisodes - drawEpisodes)
        gwdraw
    end

    if new_state.isterminal == 1
        disp('Goal Reached!')
        disp(episode)
        break;
    end
end

end

