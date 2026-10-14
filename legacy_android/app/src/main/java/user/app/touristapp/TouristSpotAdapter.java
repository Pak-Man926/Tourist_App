package user.app.touristapp;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.TextView;
import androidx.annotation.NonNull;
import androidx.recyclerview.widget.RecyclerView;
import java.util.List;

public class TouristSpotAdapter extends RecyclerView.Adapter<TouristSpotAdapter.ViewHolder>
{

    private Context context;
    private List<TouristSpot> spots;

    public TouristSpotAdapter(Context context, List<TouristSpot> spots)
    {
        this.context = context;
        this.spots = spots;
    }

    @NonNull
    @Override
    public ViewHolder onCreateViewHolder(@NonNull ViewGroup parent, int viewType)
    {
        View view = LayoutInflater.from(context).inflate(R.layout.item_tourist_spot, parent, false);
        return new ViewHolder(view);
    }

    @Override
    public void onBindViewHolder(@NonNull ViewHolder holder, int position)
    {
        TouristSpot spot = spots.get(position);
        holder.spotName.setText(spot.getName());
        holder.spotDescription.setText(spot.getDescription());
        holder.spotImage.setImageResource(spot.getImageResId());
    }

    @Override
    public int getItemCount()
    {
        return spots.size();
    }

    public static class ViewHolder extends RecyclerView.ViewHolder
    {
        ImageView spotImage;
        TextView spotName, spotDescription;

        public ViewHolder(@NonNull View itemView)
        {
            super(itemView);
            spotImage = itemView.findViewById(R.id.spotImage);
            spotName = itemView.findViewById(R.id.spotName);
            spotDescription = itemView.findViewById(R.id.spotDescription);
        }
    }
}
