package user.app.touristapp;

import android.os.Bundle;
import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.fragment.app.Fragment;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;

import java.util.ArrayList;
import java.util.List;


public class PlacesToSeeFragment extends Fragment
{

    @Nullable
    @Override
    public View onCreateView(@NonNull LayoutInflater inflater, @Nullable ViewGroup container, @Nullable Bundle savedInstanceState) {
        View view = inflater.inflate(R.layout.fragment_places_to_see, container, false);

        RecyclerView recyclerView = view.findViewById(R.id.recyclerView);
        recyclerView.setLayoutManager(new LinearLayoutManager(getContext()));

        List<TouristSpot> spots = new ArrayList<>();
        spots.add(new TouristSpot("Galway Cathedral", "Majestic cathedral with unique architecture.", R.drawable.galway_cathedral));
        spots.add(new TouristSpot("Spanish Arch", "16th-century stone arch.", R.drawable.spanish_arch));
        spots.add(new TouristSpot("Lynch’s Castle", "Medieval townhouse in the city center.", R.drawable.lynchs_castle));
        spots.add(new TouristSpot("Claddagh Village", "Historic fishing village known for its charm.", R.drawable.claddagh_village));
        spots.add(new TouristSpot("Eyre Square", "Relax and enjoy the historic park.", R.drawable.eyre_square));
        spots.add(new TouristSpot("Dunguaire Castle", "Restored 16th-century castle.", R.drawable.dunguaire_castle));




        TouristSpotAdapter adapter = new TouristSpotAdapter(getContext(), spots);
        recyclerView.setAdapter(adapter);

        return view;
    }
}