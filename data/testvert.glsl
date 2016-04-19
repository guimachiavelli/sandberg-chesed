uniform mat4 projection;
uniform mat4 modelview;

attribute vec4 vertex;
attribute vec4 color;
attribute vec2 offset;

varying vec4 vertColor;

void main() {
  vec4 pos = modelview * vertex / 0.1;
  vec4 clip = projection * pos;

  /*gl_Position = clip + projection * vec4(offset, 0, 0);*/

  gl_Position = projection *
                modelview *
                vec4(pos);

  /*vertColor = color;*/
}
