%% Συνάρτηση Main
function entropy_EEG_analysis
    % Νικόλαος Θεόδωρος Παπαδόπουλος - 2220
    % Αθανάσιος Σδούγκος - 2239

    close all;
    load 'BonnEEGdata'; % Αρχείο δεδομένων

    disp('Υπολογισμός Z');
    enZ = ApEn(Z_EEG_data); % Υπολογισμός Εντροπίας για τον Z

    disp('Υπολογισμός O');
    enO = ApEn(O_EEG_data); % Υπολογισμός Εντροπίας για τον O

    disp('Υπολογισμός N');
    enN = ApEn(N_EEG_data); % Υπολογισμός Εντροπίας για τον N

    disp('Υπολογισμός F');
    enF = ApEn(F_EEG_data); % Υπολογισμός Εντροπίας για τον F

    disp('Υπολογισμός S');
    enS = ApEn(S_EEG_data); % Υπολογισμός Εντροπίας για τον S

    EnPlot(enZ, enO, enN, enF, enS); % Δημιουργία γραφήματος
end

%%  Κορμός Υπολογισμού της Εντροπίας
function en_res = ApEn(EEG_data)    % Είσοδος: Πίνακας 100 x 4097

    [rows, ~] = size(EEG_data); % Οι γραμμές γίνονται 100
    en_res = zeros(rows, 1);    % Αρχικοποίηση του πίνακα 100x1

    m = 2; % Μέγεθος παραθύρου

    for i = 1:rows
        % Παίρνουμε το σήμα της γραμμής i (1 x 100)
        signal = EEG_data(i, :);

        % Υπολογίζουμε το SD μόνο για αυτό το σήμα
        sd_value = std(signal);

        % Υπολογίζουμε το όριο ανοχής r
        r = 0.2 * sd_value;

        % Καλούμε τον αλγόριθμο ApEn
        en_res(i) = MyApEn(m, r, signal);
    end
end 

%% Μαθηματικός Υπολογισμός Αλγορίθμου Εντροπίας
function En = MyApEn(ep, r, signal)
    
    N = length(signal); % Μέγεθος του διανύσματος
    phi = zeros(1, 2);  % Αρχικοποίηση διανύσματος 
                        % δύο θέσεων για Φ^m και Φ^m+1

    % Λούπα για τον υπολογισμό των δύο Φ
    for j = ep:ep+1
        count = zeros(1, N-j+1);    % Αρχικοποίηση διανύσματος counter 
                                    % για τον αριθμό ομοίων παραθύρων
                                    % (1x4096)
        ep_mat = zeros(N-j+1, j); % Αρχικοποίηση πίνακα με κάθε γραμμή ένα παράθυρο
                                  % για όλα τα παράθυρα (4096x2)

        % Λούπα για την ανάθεση τιμών από το σήμα στο ep_mat
        for i = 1:N-j+1
            ep_mat(i, :) = signal(i : i+j-1);
        end

        % Λούπα για την αποθήκευση όλων των συγκρίσεων
        for i = 1:N-j+1
            diffs = abs(ep_mat - ep_mat(i,:));  % Αφαιρείται κάθε μία γραμμή 
                                                % από όλες τις υπόλοιπες (4096x2)
            max_diffs = max(diffs, [], 2);      % Εύρεση του μεγαλύτερου αριθμού κάθε γραμμής -
                                                % της μεγαλύτερη απόστασης Chebyshev
            count(i) = sum(max_diffs <= r);     % Εάν η απόσταση είναι <= r
                                                % τότε προστίθεται στο count
        end
        
        % Υπολογισμοί με βάση τον αλγόριθμο
        C_im = count / (N-j+1); % 
        phi(j-ep+1) = sum(log(C_im)) / (N-j+1);
    end
    
    % Υπολογισμός της Εντροπίας
    En = phi(1) - phi(2);
end

%%  Συνάρτηση Γραφήματος Κανονικής Κατανομής
function EnPlot(enZ, enO, enN, enF, enS)
    figure('Name', 'Κανονική Κατανομή της Εντροπίας', 'Color', 'w');
    hold on;

    % Συγκέντρωση όλων των τιμών για να βρούμε τα όρια του άξονα X
    all_data = [enZ; enO; enN; enF; enS];
    min_val = min(all_data);
    max_val = max(all_data);

    % Δημιουργία άξονα X με 1000 ενδιάμεσα σημεία
    x = linspace(min_val, max_val, 1000);


    % Δημιουργία γραφήματος για τον Z
    mu = mean(enZ);     % Υπολογισμός του Μέσου Όρου της ομάδας
    sigma = std(enZ);   % Υπολογισμός της Τυπικής Απόκλισης της ομάδας
    y = normpdf(x, mu, sigma);  % Συνάρτηση Κανονικής Κατανομής
    plot(x, y, 'b', 'LineWidth', 2, 'DisplayName', 'Z');

    % Δημιουργία γραφήματος για τον O
    mu = mean(enO); sigma = std(enO);
    y = normpdf(x, mu, sigma);
    plot(x, y, 'k', 'LineWidth', 2, 'DisplayName', 'O');

    % Δημιουργία γραφήματος για τον N
    mu = mean(enN); sigma = std(enN);
    y = normpdf(x, mu, sigma);
    plot(x, y, 'g', 'LineWidth', 2, 'DisplayName', 'N');

    % Δημιουργία γραφήματος για τον F
    mu = mean(enF); sigma = std(enF);
    y = normpdf(x, mu, sigma);
    plot(x, y, 'm', 'LineWidth', 2, 'DisplayName', 'F');

    % Δημιουργία γραφήματος για τον S
    mu = mean(enS); sigma = std(enS);
    y = normpdf(x, mu, sigma);
    plot(x, y, 'r', 'LineWidth', 2, 'DisplayName', 'S');

    % Μορφοποίηση Γραφήματος
    legend('show', 'Location', 'Best'); 
    title('Κανονική Κατανομή Τιμών');
    xlabel('Τιμή Εντροπίας');
    ylabel('Πυκνότητα Πιθανότητας');
    grid on;
    hold off;
end

