import { LightningElement} from 'lwc';
import VideoPlayer from 'c/videoPlayer';

export default class MethodCaller extends LightningElement {
    video = "https://www.w3schools.com/tags/movie.mp4"; 
    
    handlePlay(){
        console.log('** in handlePlay ** '+this.template.querySelector('c-vidoe-player').play());
        this.template.querySelector('c-vidoe-player').play();
    }
    
    handlePause(){
        this.template.querySelector('c-video-player').pause();
    }
}