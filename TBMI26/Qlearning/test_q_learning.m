%% Initialize values
clc
world = 4;
gwinit(world)
state = gwstate;
Q = zeros(state.xsize,state.ysize,4);
learningRate = 0.2; % World 1,2,3: 0.4, World 4: 0.2
discountFactor = 0.7; % World 1,2,3: 0.9, World 4: 0.7
explorationFactor = 0.8; % World 1,2,3: 0.8, World 4: 0.8
not_valid_penalty = 0; % World 1,2,3: -inf, World 4: -3
numberOfEpisodes = 6000; % World 1,2,3: 4000, World 4: 6000
drawEpisodes = 5;
probability_vector = [0.25 0.25 0.25 0.25]; % down, up, right, left

e_lower = 0.0;  % epsilon lower min will approach. World 1,2,3: 0.0, World 4: 0.0
e_update = (explorationFactor - e_lower)/numberOfEpisodes;  % update factor for epsilon

%% Run Q-learning
clc
figure(world)

for episode=1:numberOfEpisodes
    gwinit(world)
    
    Q = Q_learning(Q, learningRate, discountFactor, explorationFactor,...
    not_valid_penalty, episode, numberOfEpisodes, drawEpisodes,...
    probability_vector);
    
    explorationFactor = explorationFactor - e_update;
end

disp('Learning finished!')

%% Get the path from start to goal
clc
figure(world)
gwinit(world)
gwdraw
while true
    state = gwstate;
    state_x = state.pos(1);
    state_y = state.pos(2);
    [action, ~] = chooseaction(Q,state_x,state_y,[1 2 3 4],...
                                      probability_vector, 0);

    new_state = gwaction(action);
    gwplotarrow([state_x state_y]',action);
    if new_state.isterminal == 1
        disp('Goal Reached!')
        break;
    end
end

%% Plot the V-function
figure(5)
gwinit(world)
gwdraw
gwplotallarrows(Q)


%% Print the Q-function
figure(10*world + 1)
imagesc(Q(:,:,1))

figure(10*world + 2)
imagesc(Q(:,:,2))

figure(10*world + 3)
imagesc(Q(:,:,3))

figure(10*world + 4)
imagesc(Q(:,:,4))


