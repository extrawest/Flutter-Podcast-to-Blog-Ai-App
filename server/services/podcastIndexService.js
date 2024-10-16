import podcastIndexRepository from '../repositories/podcastIndexRepository.js';
class PodcastIndexService {
    constructor() {
        this.repository = podcastIndexRepository;
    }

    async performPodcastIndexSearch() {
        await this.repository.init();
        const searchResult = await this.repository.performPodcastSearch();

        return searchResult;
    }

    async performPodcastIndexEpisodesSearch() {
        await this.repository.init();
        const searchResult = await this.repository.performEpisodesByIdSearch();

        return searchResult;
    }
}

export default new PodcastIndexService();