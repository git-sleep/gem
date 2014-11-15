describe GitSleep::CredentialsFile do
  let(:file) { GitSleep::CredentialsFile.instance }
  describe '#present?' do
    context 'when the file does not exist' do
      it 'returns false' do
        expect(file).to_not be_present
      end
    end

    context 'when the file exists' do
      before { create_valid_credentials_file }
      it 'returns true' do
        expect(file).to be_present
      end
    end
  end
  describe '#destroy' do
    context 'when the file does not exist' do
      it 'returns false' do
        expect(file).to_not be_present
        expect(file.destroy).to be false
        expect(file).to_not be_present
      end
    end
    context 'when the file exists' do
      before { create_blank_credentials_file }
      it 'returns true' do
        expect(file).to be_present
        expect(file.destroy).to be true
        expect(file).to_not be_present
      end
    end
  end
  describe '#path' do
    it 'returns the path to the thing' do
      # this method is stubbed everywhere else
      # so we must test it unstubbed
      allow(file).to receive(:path).and_call_original
      expect(File).to receive(:expand_path).with('~/.netrc')
      file.path
    end
  end
end

