%% Converts automagic output to EEGLAB .set format

data_dir = 'C:\Users\LevittLab\Downloads\GradSchool_TD_EC-EO-raw-format-individual-files\EO_GSEO_results';
out_dir = 'GradSchoolOutput';
files = dir([data_dir, '/**', '/*p_*.mat']);
eeglab;
for k = 1:length(files)
    name = files(k).name;
    if startsWith(name, 'bip')
        fprintf("Skipping %s, bad quality\n", name);
        continue
    end
    fprintf("Processing %s...\n", name);
    folder = files(k).folder;
    EEG = load(fullfile(folder, name));
    EEG = EEG.EEG;
    EEG = eeg_checkset( EEG );
    EEG = pop_reref( EEG, []);
    EEG = eeg_checkset( EEG );
    EEG = pop_saveset(EEG, 'filename',sprintf('%s.set', name(1:end-4)),'filepath',out_dir,'savemode','onefile');
end
