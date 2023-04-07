function get_gc_info() {
    var _gc = gc_get_stats();
    return "Objects Touched: " + string(_gc.objects_touched) +
    "\nObjects Collected: " + string(_gc.objects_collected) +
    "\nTraversal Time: " + string(_gc.traversal_time) +
    "\nCollection Time: " + string(_gc.collection_time) +
    "\nGC Frame: " + string(_gc.gc_frame) +
    "\nGenerataion Collected: " + string(_gc.generation_collected) +
    "\nNumber of Generations: " + string(_gc.num_generations) +
    "\nNumber of Objects in Generation: " + string(_gc.num_objects_in_generation) +
    "\nFPS: " + string(fps) + " FPS REAL: " + string(fps_real);
}