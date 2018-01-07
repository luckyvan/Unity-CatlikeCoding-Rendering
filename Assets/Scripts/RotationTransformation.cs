using UnityEngine;

public class RotationTransformation : Transformation
{

    public Vector3 rotation;

    public override Vector3 Apply(Vector3 point)
    {
        float radZ = rotation.z * Mathf.Deg2Rad;
        var sinZ = Mathf.Sin(radZ);
        var cosZ = Mathf.Cos(radZ);

        //x(1,0) + y(0,1) --> x(cosZ, sinZ) + y(-sinZ, cosZ)
        return new Vector3(
            point.x * cosZ - point.y * sinZ,
            point.x * sinZ + point.y * cosZ,
            point.z);
    }
}