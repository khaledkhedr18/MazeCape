extends MeshInstance3D
@onready var blood=$blood
@onready var others=$others

var alpha=1.0
# Called when the node enters the scene tree for the first time.
func _ready():
	var dup_mat=material_override.duplicate()
	material_override=dup_mat


func init(pos1,pos2):
	var draw_mesh=ImmediateMesh.new()
	mesh= draw_mesh
	draw_mesh.surface_begin(mesh.PRIMITIVE_LINES,material_override)
	draw_mesh.surface_add_vertex(pos1)
	draw_mesh.surface_add_vertex(pos2)
	draw_mesh.surface_end()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	alpha-=delta*1
	material_override.albedo_color.a=alpha
	
func trigger_particles(pos,gun_pos,on_enemy):
	if on_enemy:
		blood.position=pos
		blood.look_at(gun_pos)
		blood.emitting=true
	else:
		others.position=pos
		others.look_at(gun_pos)
		others.emitting=true
	
	



func _on_timer_timeout():
	queue_free()
